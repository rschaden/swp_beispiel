def full_title(page_title)
  base_title = "SWP-Beispiel"
  page_title.empty? ? base_title : "#{base_title} - #{page_title}"
end   