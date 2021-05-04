using Toybox.Media;
using Toybox.Application;

class PlaybackStartContentIterator extends Media.ContentIterator {

    function initialize() {
        ContentIterator.initialize();
    }

    // Determine if the the current track can be skipped.
    function canSkip() {
        return false;
    }
    
    function getAudio() {
		var app = Application.getApp();
		var id = app.getProperty(0);
		if (id == null) {
        	return null;
        }
    	var ref = new Media.ContentRef(id, Media.CONTENT_TYPE_AUDIO);
    	var audio = Media.getCachedContentObj(ref);
    	var pos = 50;    	    	
    	return new Media.ActiveContent(ref, audio.getMetadata(), pos);            
    }

    // Get the current media content object.
    function get() {
    	return getAudio();
    }

    // Get the current media content playback profile
    function getPlaybackProfile() {
        var profile = new Media.PlaybackProfile();
        profile.attemptSkipAfterThumbsDown = false;
        profile.playbackControls = [
            PLAYBACK_CONTROL_SKIP_BACKWARD,
            PLAYBACK_CONTROL_PLAY,
            PLAYBACK_CONTROL_SKIP_FORWARD
        ];
        profile.playbackNotificationThreshold = 1;
        profile.requirePlaybackNotification = false;
        profile.skipPreviousThreshold = null;
        profile.supportsPlaylistPreview = false;
        return profile;
    }

    // Get the next media content object.
    function next() {
    	return getAudio();    
    }

    // Get the next media content object without incrementing the iterator.
    function peekNext() {
    	return getAudio();
    }

    // Get the previous media content object without decrementing the iterator.
    function peekPrevious() {
    	return getAudio();    
    }

    // Get the previous media content object.
    function previous() {
    	return getAudio();    
    }

    // Determine if playback is currently set to shuffle.
    function shuffling() {
        return false;
    }

}
