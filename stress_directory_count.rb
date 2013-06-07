#utility to check for corrupt result files from SV application
#
#iterate over these repository directories
archiveDirectories = ['NUC - Physician to read','Stress Echo - Physician to read','Treadmill - Physician to read']
#each repository has 99 subdirectories
range = (0..99)
archiveDirectories.each do |d|
  studyCount = 0
	range.each do |i|
		#ternary operator names subdirectory appropriately
		i < 10 ? endOfPath = "Exam00#{i.to_s}" : endOfPath = "Exam0#{i.to_s}"
		path = "//{serverpath}/#{d}/#{endOfPath}"
		#count files in directory
		fc = Dir.glob(File.join(path, '**', '*')).select { |file| File.file?(file) }.count
		#if file count > 0 there is a study in this directory
		if fc > 0
			studyCount += 1
			#if file count < 12 the study corrupted on archive
			if fc < 12
				puts "Uh Oh! - #{d}/#{endOfPath} = #{fc.to_s} files"
			end
		end
	end
	#display results - ternary operator enforces proper grammar :o)
	puts "#{d} has #{studyCount.to_s} #{studyCount==1 ? "study" : "studies"}"
end
