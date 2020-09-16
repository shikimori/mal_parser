module MalParser
  class Entry::Character < Entry::Base
    FIELDS = Entry::Base::FIELDS + %i[
      japanese fullname seyu synopsis
    ]
    SYNOPSYS_REGEXP = %r{
      <h2 \s class="normal_header" [\s\S]*? </h2>
        (?<html> .*? )
      (?:<div \s class="normal_header"|<br><br><div \s style="padding:)
    }mix
    SEYU_SELECTOR = '.normal_header:contains("Voice Actors") ~ table tr td:last'

  private

    def japanese
      at_css('.breadcrumb + .normal_header span')&.text&.gsub(/[()]/, '')
    end

    def fullname
      at_css('.h1-title').text.gsub('  ', ' ')
    end

    def seyu
      css(SEYU_SELECTOR).map { |seyu_doc| parse_seyu seyu_doc }
    end

    def synopsis
      return if no_synopsis?
      return unless parse_synopsis =~ SYNOPSYS_REGEXP

      fix_synopsis $LAST_MATCH_INFO[:html].gsub(/(<br>)+\Z/, '').strip
    end

    def parse_synopsis
      at_css('#content > table > tr > td:nth-child(2)')&.inner_html
    end

    def parse_seyu seyu_doc
      url = seyu_doc.at_css('a')&.attr(:href)

      {
        id: extract_id(url),
        type: extract_type(url),
        roles: seyu_doc.at_css('small').text.split(', ')
      }
    end
  end
end
