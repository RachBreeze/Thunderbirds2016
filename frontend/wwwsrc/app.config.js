export default function(uiGmapGoogleMapApiProvider, $mdThemingProvider) {
    uiGmapGoogleMapApiProvider.configure({
        key: 'AIzaSyA6kFTYtcb1Q_9EAklhkmOi3y66ANcBpVg',
        v: '3.20', //defaults to latest 3.X anyhow
        libraries: 'weather,geometry,visualization'
    });

    $mdThemingProvider.theme('altTheme')
        .primaryPalette('indigo')
        .accentPalette('red'); // specify primary color, all
                                // other color intentions will be inherited
                                // from default
                            
    $mdThemingProvider.setDefaultTheme('altTheme');
}