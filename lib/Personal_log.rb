require 'csv'
class Personal_Log	
  def initialize(filename)		
      @filename = "#{Rails.root}/lib/#{filename}"
		
		if file_dir_or_symlink_exists?(@filename)		
			readFile
		else
			f = File.new(@filename, "w")
			f.close
			
			readFile
		end
    
  end
  
  private
  def writeFile
    CSV.open(@filename, "w") do |csv| 
      @fileContent.each do |p| 
        csv << p
      end 
    end 
  end
  
  private
  def readFile
    @fileContent = CSV.read(@filename)
  end
  
  public
  def findRecord(position, searchTerm)
    #holder = @fileContent.find {|row| row[position] == '#{searchTerm}'}
    holder = @fileContent.find{|person| person[position] =~/#{searchTerm}/}
    #puts holder.class
    return holder
  end
  
  private
  def findAllRecords
  end
  
  public
  def updateRecord(position, searchTerm, newText)
    holder = @fileContent.find{|person| person[position] =~/#{searchTerm}/} 
    #p @fileContent
    holder[position] = newText 
    
    # call the writeFile method, this will write all changes back to the text.txt file
    writeFile 
  end
  
  public
  def newRecord(email, town, firstname, lastname, mobile)
    # add code here to add a new record
    array = Array.new
    array.push email
    array.push town
    array.push firstname
    array.push lastname
    array.push mobile
    
    CSV.open(@filename, "a+") do |csv|
      csv << array
    end
  end
		
		public
		def recordSearch(email, name_search, category_id, date)
			array = Array.new
			array.push email
			array.push name_search	
			array.push category_id
			array.push date
			
			CSV.open(@filename, "a+") do |csv|
      csv << array
    	end
		end
  
  def newLogRecord(arr)
    CSV.open(@filename, "a+") do |csv|
      csv << arr
    end
  end
  
  public
  # method to remove a line from the csv file. position is the data item in the csv row.
  def deleteRecord(position, searchTerm)
    # add code here to delete a line from the csv file
     readFile # call the method to read the content of the file
     holder = @fileContent.find{|person| person[position] =~/#{searchTerm}/} # locate the record in the csv file
     @fileContent.delete(holder) # remove the identified record from the @fileContent array
     writeFile # write the content of @fileContent array back to the csv file
  end
  
  public
  def deleteRecordByIndex(pos)
    # add code here to delete a line at a specific row from the csv file
     readFile # call the method to read the content of the file
     @fileContent.delete_at(pos) # remove the identified record from the @fileContent array
     writeFile # write the content of @fileContent array back to the csv file
  end
		
		
		
		
		
		
		
		private 
		def file_dir_or_symlink_exists?(path_to_file)
  		File.exist?(path_to_file) || File.symlink?(path_to_file)
		end
end


#p = EmployeeLogger.new("text2.txt")
#t = p.findRecord(0, 'jon@email.com')
#p.updateRecord(1, "Legend", "Cool")
#p.deleteRecord(2,"Johnny")
#p.newRecord("jon@email.com", "Naas", "Johnny", "McCarthy", "0834342009")
#p.deleteRecordByIndex(3)