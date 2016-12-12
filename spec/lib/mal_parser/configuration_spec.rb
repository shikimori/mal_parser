describe MalParser::Configuration do
  let(:config) { MalParser::Configuration.new }

  describe 'default value' do
    it { expect(config.http_get).to eq MalParser::Configuration::HTTP_GET }
  end

  describe 'configured value' do
    before { config.http_get = :zzz }
    it { expect(config.http_get).to eq :zzz }
  end
end
