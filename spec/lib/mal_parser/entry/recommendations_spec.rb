describe MalParser::Entry::Recommendations do
  let(:parser) { MalParser::Entry::Recommendations.new id, type }
  let(:id) { 32_948 }
  let(:type) { :anime }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq [
        { id: 28735, type: :anime },
        { id: 31646, type: :anime },
        { id: 25835, type: :anime },
        { id: 16662, type: :anime },
        { id: 22789, type: :anime },
        { id: 31771, type: :anime },
        { id: 13673, type: :anime },
        { id: 32949, type: :anime },
        { id: 36317, type: :anime },
        { id: 12189, type: :anime },
        { id: 40513, type: :anime },
        { id: 16, type: :anime },
        { id: 31953, type: :anime },
        { id: 37965, type: :anime },
        { id: 34984, type: :anime },
        { id: 12531, type: :anime },
        { id: 10800, type: :anime },
        { id: 33352, type: :anime },
        { id: 23847, type: :anime },
        { id: 39468, type: :anime },
        { id: 457, type: :anime },
        { id: 36653, type: :anime }
      ]
    end

    describe 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end
  end
end
