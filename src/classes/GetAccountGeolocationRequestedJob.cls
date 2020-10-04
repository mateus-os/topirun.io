/**
 * @author mateus-os
 */
public class GetAccountGeolocationRequestedJob implements Schedulable, Database.AllowsCallouts{
    
    public void execute (SchedulableContext context) {
        getAccountsGeolocation();

        abort();
        start();
    }

    @future (callout = true)
    public static void getAccountsGeolocation() {
        AccountRepository repository = new AccountRepository();

        List<Account> accounts = repository.findByGeolocationRequested();

        GetAccountGeolocationAddressOutbound service = new GetAccountGeolocationAddressOutbound();

        List<Account> accountsGeolocationRequested = service.getAccountGeolocation(accounts);
        
        repository.store(accountsGeolocationRequested);
    }

    public static void start() {
        System.schedule('Update geolocation requested accounts', scheduleEveryTwentyMinutes(), new GetAccountGeolocationRequestedJob());
    }

    public static void abort() {
        List<CronTrigger> schedules = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Update geolocation requested accounts'];

        for (CronTrigger schedule : schedules){
            System.abortJob(schedule.Id);
        }
    }

    public static String scheduleEveryTwentyMinutes() {
        Datetime nextSchedule = System.now().addMinutes(20);
        
        String day = string.valueOf(nextSchedule.day());
        String month = string.valueOf(nextSchedule.month());
        String hour = string.valueOf(nextSchedule.hour());
        String minute = string.valueOf(nextSchedule.minute());
        String second = string.valueOf(nextSchedule.second());
        String year = string.valueOf(nextSchedule.year());

        return '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
    }
}