module CustomPaginationHelper
  class CustomPaginationRenderer < Kaminari::Helpers::Tag
    def page_number(page)
      @template.content_tag :li, class: "page #{"active" if page == current_page}" do
        @template.link_to page, url(page), class: "page"
      end
    end

    def previous_page
      @template.content_tag :li do
        @template.link_to "＜", url(previous_page), class: "page"
      end
    end

    def next_page
      @template.content_tag :li do
        @template.link_to "＞", url(next_page), class: "page"
      end
    end

    def first_page
      @template.content_tag :li do
        @template.link_to "先頭", url(1), class: "page"
      end
    end

    def last_page
      @template.content_tag :li do
        @template.link_to "最後", url(total_pages), class: "page"
      end
    end

    # Add these methods to customize the labels for the pagination buttons
    def gap
      @template.content_tag :li, "…", class: "disabled"
    end

    def first_page_label
      "先頭"
    end

    def last_page_label
      "最後"
    end

    def previous_page_label
      "＜"
    end

    def next_page_label
      "＞"
    end
  end
end
