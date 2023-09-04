describe MalParser::Configuration do
  let(:config) { described_class.new }

  describe 'default value' do
    it { expect(config.http_get).to eq described_class::HTTP_GET }
  end

  describe 'configured value' do
    before { config.http_get = :zzz }
    it { expect(config.http_get).to eq :zzz }
  end
end
