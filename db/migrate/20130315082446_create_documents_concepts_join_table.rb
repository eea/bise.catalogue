class CreateDocumentsConceptsJoinTable < ActiveRecord::Migration

    def up
        create_table :documents_concepts, :id => false do |t|
          t.integer :document_id
          t.integer :concept_id
        end

        # add_index :documents_concepts, [ :document_id, :concept_id ]
    end

    def down
        drop_table :documents_concepts
        # remove_index :documents_concepts, [ :document_id, :concept_id ]
    end

end
