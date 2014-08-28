package bm

import com.baoming.Comp
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

    def toList(def file,def t,def uid) {

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
        def titles = []
        for (int i = 0; i < totalRow; i++) {

            def cols = []
            for(int j = 0 ;j < totalCol;j++){
                if(i == 0){
                    String str = sheet.getCell(j, i).getContents();
                    titles << str
                }else{
                    String str = sheet.getCell(j, i).getContents();
                    cols << str
                }
            }
            if(i > 0 && cols && !cols.empty){
                try {
                    new Comp(num: cols[0],content: cols.join(','),type: t,uid:uid).save()
                } catch (Exception e) {
                }
                list << cols[0]
            }
        }
        if(list.empty) {
            return
        }

        return [titles:titles,list:list]

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
