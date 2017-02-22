describe MalParser::Entry::Recommendations do
  let(:parser) { MalParser::Entry::Recommendations.new id, type }
  let(:id) { 32_948 }
  let(:type) { :anime }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq [
        {
          id: 28_735,
          type: :anime
        }, {
          id: 16_662,
          type: :anime
        }, {
          id: 31_771,
          type: :anime
        }, {
          id: 13_673,
          type: :anime
        }, {
          id: 31_953,
          type: :anime
        }, {
          id: 25_835,
          type: :anime
        }
      ]
    end

    describe 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end
  end
end
