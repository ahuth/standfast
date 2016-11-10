require 'rails_helper'

describe Email::Processor do
  let(:processor) { described_class.new(email) }
  let(:email) { OpenStruct.new({
    from: { email: seat.email },
    subject: subject,
    body: "Wrote codes"
  }) }

  describe "#process" do
    let!(:initial_response_count) { Response.count }

    context "for a non-standard subject" do
      let(:subject) { "H4xor!" }
      let(:seat) { seats(:jane_blue_team_eric_seat) }

      before do
        processor.process
      end

      it "does not create a response" do
        expect(Response.count).to eq(initial_response_count)
      end
    end

    context "for a standard subject" do
      let(:subject) { "What did you do today? [#{team.id}]" }

      context "for a team that does not exist" do
        let(:team) { Team.new(id: 666) }
        let(:seat) { seats(:jane_blue_team_eric_seat) }

        before do
          expect(team).to_not be_persisted
          processor.process
        end

        it "does not create a response" do
          expect(Response.count).to eq(initial_response_count)
        end
      end

      context "for a team that exists" do
        let(:team) { teams(:jane_blue_team) }

        context "that the seat is not on" do
          let(:seat) { seats(:bob_black_team_ted_seat) }

          before do
            expect(seat.team_id).to_not eq(team.id)
            processor.process
          end

          it "does not create a response" do
            expect(Response.count).to eq(initial_response_count)
          end
        end

        context "that the seat is on" do
          let(:seat) { seats(:jane_blue_team_eric_seat) }
          let(:last_response) { Response.last }

          before do
            expect(seat.team_id).to eq(team.id)
          end

          context "when there is already a response" do
            let!(:previous_response) { Response.create!(seat: seat, body: "Hi") }

            before do
              expect(previous_response).to_not be_handled
              processor.process
            end

            it "marks previous responses as handled" do
              expect(previous_response.reload).to be_handled
            end

            it "creates an unhandled response" do
              expect(Response.count).to eq(initial_response_count + 2)
              expect(last_response).to_not be_handled
              expect(last_response.seat_id).to eq(seat.id)
              expect(last_response.body).to eq("Wrote codes")
            end
          end

          context "when there is not already a response" do
            before do
              expect(seat.responses.count).to eq(0)
              processor.process
            end

            it "creates an unhandled response" do
              expect(Response.count).to eq(initial_response_count + 1)
              expect(last_response).to_not be_handled
              expect(last_response.seat_id).to eq(seat.id)
              expect(last_response.body).to eq("Wrote codes")
            end
          end
        end
      end
    end
  end
end
