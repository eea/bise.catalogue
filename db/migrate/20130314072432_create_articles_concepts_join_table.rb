class CreateArticlesConceptsJoinTable < ActiveRecord::Migration

    def up
        create_table :articles_concepts, :id => false do |t|
          t.integer :article_id
          t.integer :concept_id
        end

        # add_index :articles_concepts, [ :article_id, :concept_id ]
    end

    def down
        drop_table :articles_concepts
        # remove_index :articles_concepts, [ :article_id, :concept_id ]
    end

end
