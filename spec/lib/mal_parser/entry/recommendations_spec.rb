describe MalParser::Entry::Recommendations do
  let(:parser) { MalParser::Entry::Recommendations.new id, type }
  let(:id) { 32_948 }
  let(:type) { :anime }

  describe '#call', :vcr do
    subject! { parser.call }

    it do
      is_expected.to eq [
        {
          id: 28_735,
          type: :anime
        }, {
          id: 31_771,
          type: :anime
        }, {
          id: 13_673,
          type: :anime
        }, {
          id: 25_835,
          type: :anime
        }, {
          id: 16_662,
          type: :anime
        }
      ]
    end
  end
end
