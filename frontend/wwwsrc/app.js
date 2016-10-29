import 'angular-material/angular-material.scss';

import angular from 'angular';
import angularMaterial from 'angular-material';
import angularGoogleMaps from 'angular-google-maps';
import angularSimpleLogger from 'angular-simple-logger';

import components from './components/components.module.js';
import shared from './shared/shared.module.js';

import config from './app.config.js';

let app = angular.module('missme', [components, shared, 'ngMaterial', 'uiGmapgoogle-maps'])
    .config(config)
    .constant('API_URL', 'http://192.168.226.201:54621');