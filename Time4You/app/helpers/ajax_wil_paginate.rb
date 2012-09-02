class AjaxWillPaginate &lt; WillPaginate::LinkRenderer
  def prepare(collection, options, template)
    @update = options[:update]
    super
  end
  protected
  def page_link(page, text, attributes = {})
    @template.link_to_remote(text, {
      :url     =&gt; url_for(page),
      :method  =&gt; :get,
      :update =&gt; @update
    })
  end
end