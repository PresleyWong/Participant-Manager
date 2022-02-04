class Participant < ApplicationRecord
    has_many :appointments
    has_many :events, through: :appointments

    scope :filtered_by_server, ->(query_params, locality) { where("english_name ILIKE ?", "%#{query_params[:search_item]}%").where('locality IN (?)', locality) }
    scope :filtered_by_admin, ->(query_params) { where("english_name ILIKE ?", "%#{query_params[:search_item]}%") }

    def self.to_csv
        lookup = {
            gender: 'Gender', 
            english_name: 'English Name', 
            chinese_name: 'Chinese Name', 
            email: 'Email Address', 
            phone: 'Phone Number', 
            college: 'University/College', 
            academic_year: 'Academic Year', 
            language: 'Language', 
            remarks: 'Remarks', 
        }
    
        CSV.generate(headers: true) do |csv|
          csv << lookup.values    
          all.each do |participant|
            csv << lookup.keys.map { |attr| participant.send(attr) }
          end
        end
    end

    def self.import(file, event)
      column_whitelist = ["Gender", "English Name", "Chinese Name", "Email Address", "Phone Number", "University/College", "Academic Year", "Language", "Remarks"]
      case File.extname(file.original_filename)
        when ".csv" then 
          CSV.foreach(file.path, headers: true) do |row|
            to_hash = row.to_hash     
                       
            participant = Participant.where(email: to_hash['Email Address']).first_or_create do |p|
              p.gender = to_hash['Gender']        
              p.english_name = to_hash['English Name']
              p.chinese_name = to_hash['Chinese Name']
              p.email = to_hash['Email Address']
              p.phone = to_hash['Phone Number']
              p.college = to_hash['University/College']
              p.academic_year = to_hash['Academic Year']
              p.language = to_hash['Language']
              p.remarks = to_hash['Remarks']              
            end

            participant.update(
              gender: to_hash['Gender'],
              english_name: to_hash['English Name'],
              chinese_name: to_hash['Chinese Name'],
              email: to_hash['Email Address'],
              phone: to_hash['Phone Number'],
              college: to_hash['University/College'],
              academic_year: to_hash['Academic Year'],
              language: to_hash['Language'],
              remarks: to_hash['Remarks']  
            )
            
            Appointment.create(
              participant_id: participant.id, 
              event_id: event.id,
              server_name: "[placeholder]"
            )         

          end
       
    
        else raise "Unknown file type: #{file.original_filename}"
      end
    end
  
    
end
