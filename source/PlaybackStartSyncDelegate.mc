using Toybox.Communications;
using Toybox.Media;
using Toybox.Application;

class PlaybackStartSyncDelegate extends Media.SyncDelegate {

	var url = "https://github.com/primetime00/garminWifiTest/raw/main/audio/test.mp3";

    function initialize() {
        SyncDelegate.initialize();        
    }
    
    function onDone(code, data) {    	
    	if (code == 200) {
    		var app = Application.getApp();
    		app.setProperty(0, data.getId());
    		System.println("Download Complete!");
    		Media.notifySyncProgress(100);    		
    	}
    	System.println("ALL DONE?");
    	Media.notifySyncComplete(null);
    	
    }

    // Called when the system starts a sync of the app.
    // The app should begin to download songs chosen in the configure
    // sync view .
    function onStartSync() {
        var options = {:method => Communications.HTTP_REQUEST_METHOD_GET,
                       :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_AUDIO,
                       :mediaEncoding => Media.ENCODING_MP3};
        Communications.makeWebRequest(url, null, options, self.method(:onDone));    
        }

    // Called by the system to determine if the app needs to be synced.
    function isSyncNeeded() {
    	var app = Application.getApp();
    	var id = app.getProperty(0);
    	return id == null;
    }

    // Called when the user chooses to cancel an active sync.
    function onStopSync() {
        Communications.cancelAllRequests();
        Media.notifySyncComplete(null);
    }
}
