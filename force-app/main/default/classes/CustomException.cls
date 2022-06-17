public with sharing class CustomException extends Exception {

    // Deliberately empty
    public static void exceptionHandling(Database.SaveResult[] saveResult){
        System.debugb('Test');
        for(Database.SaveResult item : saveResult){
            if(!item.isSuccess()){
                for(Database.Error err : item.getErrors()){
                    throw new CustomException(err.getMessage());
                }
            }
        }
    }

    public static void printErrorInfo(Exception err){
        System.Debug('\n\nError Message: ' + err.getMessage());
        System.Debug('Error Line: ' + err.getLineNumber());
    }
}