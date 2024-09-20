class DownloadRepoAsZip
    def start owner, repo, ref, token, product
        begin
            zip_link = "https://github.com/#{owner}/#{repo}/archive/refs/heads/#{ref}.zip"
            temp_file = Tempfile.new([repo, '.zip'])
            
            curl_command = "curl -L -H 'Authorization: token #{token}' -o #{temp_file.path} #{zip_link}"
            
            stdout, stderr, status = Open3.capture3(curl_command)
            
        if status.success?
            puts "Successfully downloaded #{temp_file.path}"
            product.folder.attach(
                io: File.open(temp_file.path), 
                filename: "#{repo}-#{ref}.zip", 
                content_type: 'application/zip'
            )
        else
            error =  "Failed to download ZIP: #{stderr}"
            temp_file.close
            temp_file.unlink
            return error
        end
        rescue => e
            error = "Exception occurred: #{e.message}"
            return error
        ensure
            return temp_file.path
        end
    end
    
end