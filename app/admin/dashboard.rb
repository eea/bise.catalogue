ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do

    columns do
      column span: 3 do
        panel 'Recent Documents' do
          table_for Document.last(5) do
            column 'Id', :id
            column 'Title' do |doc|
              link_to(doc.title, admin_document_path(doc))
            end
            # column 'Total answers' do |question|
            #   status_tag "#{question.answers.size.to_s} answers", :ok
            # end
          end
        end

        panel 'Recent Links' do
          table_for Link.last(5) do
            column 'Id', :id
            column 'Title' do |link|
              link_to(link.title, admin_link_path(link))
            end
          end
        end

        panel 'Recent Webpages' do
          table_for Article.last(5) do
            column 'Id', :id
            column 'Title' do |article|
              link_to(article.title, admin_article_path(article))
            end
          end
        end
      end

      column do
        panel 'Other Details' do
          # para 'Welcome to JourneyJournal.'
          div class: 'blank_slate_container', id: 'others_panel' do
            span class: 'blank_slate' do
              span I18n.t('active_admin.dashboard_welcome.welcome')
              small I18n.t('active_admin.dashboard_welcome.call_to_action')
            end
          end
        end
      end
    end
  end

  # menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  # content title: proc{ I18n.t("active_admin.dashboard") } do
  #   div class: "blank_slate_container", id: "dashboard_default_message" do
  #     span class: "blank_slate" do
  #       span I18n.t("active_admin.dashboard_welcome.welcome")
  #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #     end
  #   end

  #   # Here is an example of a simple dashboard with columns and panels.
  #   #
  #   # columns do
  #   #   column do
  #   #     panel "Recent Posts" do
  #   #       ul do
  #   #         Post.recent(5).map do |post|
  #   #           li link_to(post.title, admin_post_path(post))
  #   #         end
  #   #       end
  #   #     end
  #   #   end

  #   #   column do
  #   #     panel "Info" do
  #   #       para "Welcome to ActiveAdmin."
  #   #     end
  #   #   end
  #   # end
  # end # content
end
