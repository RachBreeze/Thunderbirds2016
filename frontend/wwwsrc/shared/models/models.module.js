import angular from 'angular';
import angularResource from 'angular-resource';

import Profile from './Profile.factory.js';
import Sighting from './Sighting.factory.js';
import Tweet from './Tweet.factory.js';
import InstagramPost from './InstagramPost.factory.js';

let models = angular.module('mm.models', [angularResource])
    .factory('Profile', Profile)
    .factory('Sighting', Sighting)
    .factory('Tweet', Tweet)
    .factory('InstagramPost', InstagramPost);

export default models.name;