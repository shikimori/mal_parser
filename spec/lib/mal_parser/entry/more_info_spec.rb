describe MalParser::Entry::MoreInfo do
  let(:parser) { described_class.new id, type }

  describe '#call', :vcr do
    subject { parser.call }
    let(:id) { 32_948 }
    let(:type) { :anime }

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
      let(:id) { 35_120 }
      it { is_expected.to be_nil }
    end

    context 'multiline' do
      let(:id) { 150_413 }
      let(:type) { :manga }
      it do
        is_expected.to eq 'Volume 1 includes a prologue.' \
          "\n\n" \
          '231 chapters were published in the web novel, which ' \
          'were recompiled for a total of 22 chapters in the print release. ' \
          '[MAL]'
      end
    end
  end
end
