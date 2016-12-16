[![Travis CI](https://travis-ci.org/shikimori/mal_parser.svg?branch=master)](https://travis-ci.org/shikimori/mal_parser) [![Code Climate](https://codeclimate.com/github/shikimori/mal_parser/badges/gpa.svg)](https://codeclimate.com/github/shikimori/mal_parser)

### Usage
```ruby
# get first page of animes ordered by recently updated
MalParser::Catalog::Page.call type: 'anime', page: 0, sorting: 'updated_at'

# get first page of animes ordered by name
MalParser::Catalog::Page.call type: 'manga', page: 0, sorting: 'name'

# get anime id=1
MalParser::Entry::Anime.call 1

# get anime id=1 characters
MalParser::Entry::Characters.new 1, :anime

# get anime id=1 recommendations
MalParser::Entry::Recommendations.new 1, :anime

# get manga id=1
MalParser::Entry::Manga.call 1

# get character id=1
MalParser::Entry::Character.call 1

# get person id=1
MalParser::Entry::Person.call 1
```
