public with sharing class DonationReconLWCController {
    
    @AuraEnabled
    public static List<Donations__c> retrieveDonationList(String queryString){
        try {
            return Database.query(queryString);
        } catch (Exception err) {
            CustomException.printErrorInfo(err);
            throw new CustomException(err.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getSystemToday(){
        try {
            return Datetime.now().format('yyyy-MM-dd', 'Asia/Singapore');
        } catch (Exception err) {
            CustomException.printErrorInfo(err);
            throw new CustomException(err.getMessage());
        }
    }


    @AuraEnabled
    public static String updateDonation(List<Id> donationIdList, String donationStatus){
        try {
            List<Donations__c> donationToUpdateList = new List<Donations__c>();

            for(Id donationId : donationIdList){
                System.Debug('\n\ndonationId\n' + donationId);
                donationToUpdateList.add(new Donations__c(
                    id = donationId, 
                    Donation_Status__c = donationStatus,
                    Cleared_Datetime__c = donationStatus == 'Cleared' ? System.now() : null
                ));
            }

            
            Database.SaveResult[] donationsUpdateResult = Database.update(donationToUpdateList, false);

            String resultMessage = '';
            Integer successCount = 0;
            Integer failCount = 0;
            for(Database.SaveResult resultItem : donationsUpdateResult){
                System.Debug('\n\nresultItem\n' + resultItem);
                if(resultItem.isSuccess()){
                    successCount++;
                }
                else{
                    failCount++;
                }
            }

            
            if(successCount > 0){
                resultMessage += String.valueOf(successCount) + ' record';
                resultMessage += String.valueOf(successCount) =='1' ? ' was' : 's were';
                resultMessage += ' updated successfully.\n';
                
            }
            if(failCount > 0){
                resultMessage += String.valueOf(failCount) + ' record';
                resultMessage += String.valueOf(failCount) == '1' ? ' was' : 's were';
                resultMessage += ' failed to update.';
            }
            
            return resultMessage;
        } catch (Exception err) {
            CustomException.printErrorInfo(err);
            throw new CustomException(err.getMessage());
        }
    }
}