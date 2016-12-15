module MalParser
  class Entry::Character < Entry::Base
    FIELDS = Entry::Base::FIELDS + %i(
      japanese fullname seyu synopsis
    )
    SYNOPSYS_REGEXP = %r{
      <div \s class="normal_header" [\s\S]*? </div>
        (?<html> [\s\S]*? )
      <div \s class="normal_header"
    }mix
    SEYU_SELECTOR = '.normal_header:contains("Voice Actors") ~ table tr td:last'

  private

    def japanese
      css('.breadcrumb + .normal_header span').text.gsub(/[()]/, '')
    end

    def fullname
      css('h1').text.gsub('  ', ' ')
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
      css('#content > table > tr > td:nth-child(2)').to_html
    end

    def parse_seyu seyu_doc
      url = seyu_doc.css("a").first&.attr(:href)

      {
        id: extract_id(url),
        type: extract_type(url),
        role: seyu_doc.css('small').text
      }
    end
  end
end
