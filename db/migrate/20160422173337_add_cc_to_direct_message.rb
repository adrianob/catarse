class AddCcToDirectMessage < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE OR REPLACE FUNCTION send_direct_message() RETURNS trigger
          LANGUAGE plpgsql
          AS $$
          BEGIN
              INSERT INTO direct_message_notifications(user_id, direct_message_id, from_email, from_name, template_name, locale, created_at, updated_at, metadata  ) 
              VALUES (new.to_user_id, new.id, new.from_email, new.from_name, 'direct_message', 'pt', current_timestamp, current_timestamp, ('{ "cc": "'|| new.from_email ||'" } ')::jsonb );
              RETURN NEW;
          END;
          $$;
      SQL
  end
end
