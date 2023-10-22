$archivedate = get-date -format "dd.MM.yyyy"
$archivename = "foo"
#$archivename = "gdrive.doc.bkup.$archivedate"

copy-item -Path "<gdrive path to ods files>\*.ods" -Destination "<temp directory for compression>"
Compress-Archive -Path "<temp directory for compression>\*.*" -CompressionLevel Optimal -DestinationPath <local directory for compressed archive>\$archivename.zip
remove-item -Path "<temp directory for compression>"


 
 
