class CatCardComponent < ViewComponent::Base
  with_collection_parameter :cat

  def initialize(cat:)
    @cat = cat
  end

  def call
    link_to cat_path(@cat), class: "card-container", data: { turbo: false } do
      content_tag :div do
        image = @cat.images.first&.url || asset_path("sample_cat_image.jpeg")
        safe_join([
          content_tag(:div, class: "image-container") do
            image_tag(image, class: "square-image")
          end,
          content_tag(:div, class: "flex justify-center space-x-card-status") do
            safe_join([
              content_tag(:div, class: "status-box cat-name font-bold text-gray-500") do
                content_tag(:h3, @cat.name)
              end,
              content_tag(:div, class: "cat-info") do
                safe_join([
                  content_tag(:p, "#{@cat.age}才", class: "status-box font-bold text-gray-500 cat-age"),
                  content_tag(:p, @cat.gender, class: "status-box font-bold text-gray-500 cat-gender")
                ])
              end
            ])
          end,
          content_tag(:p, @cat.short_description, class: "short-comment-box text-gray-500 mt-4 text-center")
        ])
      end
    end
  end
end
