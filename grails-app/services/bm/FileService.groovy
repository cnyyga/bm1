package bm

import org.apache.commons.io.FileUtils

class FileService {

    def grailsApplication

    def upload(def file,def modelName = "sys") {
        if(file &&  !file.empty) {
            def cal = Calendar.instance
            def fileName1 = file.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "${UUID.randomUUID().toString()}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            storeName1 = "${modelName}/${cal.get(Calendar.MONTH)+1}/${cal.get(Calendar.DATE)}/${storeName1}"
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file.transferTo(f1)
            return storeName1
        }

    }
}
