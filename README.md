[![Travis CI](https://travis-ci.org/shikimori/mal_parser.svg?branch=master)](https://travis-ci.org/shikimori/mal_parser) [![Code Climate](https://codeclimate.com/github/shikimori/mal_parser/badges/gpa.svg)](https://codeclimate.com/github/shikimori/mal_parser)

### Usage
```ruby
# get first page of animes ordered by recently updated
MalParser::Catalog::Page.call type: 'anime', page: 0, sorting: 'updated_at'

# get first page of animes ordered by name
MalParser::Catalog::Page.call type: 'manga', page: 0, sorting: 'name'

# get anime id=1
MalParser::Entry::Anime.call 1
```
