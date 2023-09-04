describe MalParser::Entry::MoreInfo do
  let(:parser) { described_class.new id, type }
  let(:id) { 32_948 }
  let(:type) { :anime }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq(
        'Episodes 1 and 2 were previewed at a screening on October 1, 2016. ' \
          'Regular broadcasting began on October 14, 2016. ' \
          '[MAL]'
      )
    end

    context 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    context 'no more info' do
      let(:id) { 35120 }
      it { is_expected.to eq '[MAL]' }
    end
  end
end
