# == Schema Information
#
# Table name: group_events
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  start_date  :date
#  end_date    :date
#  duration    :integer
#  status      :integer          default("draft")
#  latitude    :decimal(10, 6)
#  longitude   :decimal(10, 6)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe GroupEvent do
  describe 'validations' do
    it { should validate_presence_of(:status) }

    context 'when it\'s a draft' do
      context 'when only the name is set' do
        subject { build(:group_event, :empty_draft, name: 'Name') }

        it 'must be valid' do
          expect(subject.valid?).to be true
        end
      end

      context 'when name isn\'t set' do
        subject { build(:group_event, :empty_draft) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
        end
      end
    end

    context 'when is published' do
      context 'when name isn\'t set' do
        subject { build(:group_event, name: nil) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to eq ['Name can\'t be blank']
        end
      end

      context 'when description isn\'t set' do
        subject { build(:group_event, description: nil) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to eq ['Description can\'t be blank']
        end
      end

      context 'when latitude isn\'t set' do
        subject { build(:group_event, latitude: nil) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to eq ['Latitude can\'t be blank']
        end
      end

      context 'when longitude isn\'t set' do
        subject { build(:group_event, longitude: nil) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to eq ['Longitude can\'t be blank']
        end
      end

      context 'when start_date is set but end_date and duration are not' do
        subject { build(:group_event, end_date: nil, duration: nil) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to eq ['End date can\'t be blank', 'Duration can\'t be blank']
        end
      end

      context 'when end_date is set but start_date and duration are not' do
        subject { build(:group_event, start_date: nil, duration: nil) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to eq ['Start date can\'t be blank', 'Duration can\'t be blank']
        end
      end

      context 'when duration is set but start_date and end_date are not' do
        subject { build(:group_event, duration: 10, start_date: nil, end_date: nil) }

        it 'must not be valid' do
          expect(subject.valid?).to be false
          expect(subject.errors.full_messages).to eq ['Start date can\'t be blank', 'End date can\'t be blank']
        end
      end

      context 'when start_date and end_date are set but duration is not' do
        context 'when start_date is before than end_date' do
          subject { build(:group_event) }

          it 'must be valid' do
            expect(subject.valid?).to be true
          end
        end

        context 'when start_date is equals to end_date' do
          subject { build(:group_event, start_date: Date.today + 1, end_date: Date.today + 1) }

          it 'must be valid' do
            expect(subject.valid?).to be true
          end
        end

        context 'when start_date is after than end_date' do
          subject { build(:group_event, start_date: Date.today + 10, end_date: Date.today + 1) }

          it 'must not be valid' do
            expect(subject.valid?).to be false
            expect(subject.errors.full_messages).to eq ['End date must be after the start date']
          end
        end

        context 'when start_date, end_date and duration are set' do
          context 'when the values are correct' do
            subject do
              build(:group_event, start_date: Date.today + 1, end_date: Date.today + 10, duration: 9)
            end

            it 'must be valid' do
              expect(subject.valid?).to be true
            end
          end

          context 'when the values are incorrect' do
            subject do
              build(:group_event, start_date: Date.today + 1, end_date: Date.today + 10, duration: 8)
            end

            it 'must not be valid' do
              expect(subject.valid?).to be false
              expect(subject.errors.full_messages).to eq ['Duration is not correct']
            end
          end
        end
      end
    end
  end

  describe 'callbacks' do
    context 'when start_date and end_date are set but duration is not' do
      subject do
        create(:group_event, start_date: Date.today + 1, end_date: Date.today + 6, duration: nil)
      end

      it 'calculates the duration' do
        expect(subject.duration).to eq 5
      end
    end

    context 'when start_date and duration are set but end_date is not' do
      subject do
        create(:group_event, start_date: Date.today + 1, end_date: nil, duration: 5)
      end

      it 'calculates the end_date' do
        expect(subject.end_date).to eq Date.today + 6
      end
    end

    context 'when end_date and duration are set but start_date is not' do
      subject do
        create(:group_event, start_date: nil, end_date: Date.today + 6, duration: 5)
      end

      it 'calculates the start_date' do
        expect(subject.start_date).to eq Date.today + 1
      end
    end
  end

  describe 'destroy' do
    subject { create(:group_event) }

    context 'when the event hasn\'t be destroyed' do
      it 'must have deleted_at blank' do
        expect(subject.deleted_at).to be_nil
      end
    end

    context 'when the event is destroyed' do
      it 'must be kepted in the database' do
        subject.destroy
        expect(subject.reload.deleted_at).to be_within(5.seconds).of Time.zone.now
      end
    end
  end
end
