describe MalParser do
  after { MalParser.reset }

  describe '.configuration' do
    it { expect(MalParser.configuration).to be_kind_of MalParser::Configuration }
  end

  describe '.configure' do
    before do
      MalParser.configure { |config| config.http_get = :xxx }
    end
    it { expect(MalParser.configuration.http_get).to eq :xxx }
  end

  describe '.reset' do
    before do
      MalParser.configure { |config| config.http_get = :xxx }
      MalParser.reset
    end
    it { expect(MalParser.configuration.http_get).to eq MalParser::Configuration::HTTP_GET }
  end
end
