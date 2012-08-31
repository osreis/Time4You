# ClientSideValidations Initializer


#Uncomment the following block if you want each input field to have the validation messages attached.
 ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
   unless html_tag =~ /^<label/
     %{<div class="field_with_errors">#{html_tag}<span for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</span></div>}.html_safe
   else
     %{<div class="field_with_errors">#{html_tag}</div>}.html_safe
   end

 end

