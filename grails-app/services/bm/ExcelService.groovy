package bm

import com.baoming.account.Student
import jxl.Workbook
import jxl.read.biff.BiffException

class ExcelService {

    def imp(def file,def type) {
        def work
        try {
            InputStream is = file.getInputStream();
            work = Workbook.getWorkbook(is);
        } catch (Exception e) {
            log.error(e.message,e)
            return
        }
        def sheet
        try {
            sheet = work.getSheet(0);
        } catch (IndexOutOfBoundsException e) {
            log.error(e.message,e)
            return
        }
        int totalRow = sheet.getRows();
        int totalCol = sheet.getColumns();
        println("totalRow:${totalRow},totalCol:$totalCol")
        def list = []
        for (int i = 2; i < totalRow; i++) {
            String str = sheet.getCell(0, i).getContents();
            list << str
        }
        if(list.empty) {
            return
        }

        return update(type,list)
    }

    def update(def type,def nums) {
        try {
            if(type == '1'){
                return Student.executeUpdate("update Student a set a.admission=:bb where a.number in :aa",[aa:nums,bb:Student.Admission.OK])
            }else if(type == '2') {
                return Student.executeUpdate("update Student a set a.registration=:bb where a.number in :aa",[aa:nums,bb:Student.Registration.OK])
            }
        } catch (Exception e) {
            log.error(e.message,e)
        }

    }
}
