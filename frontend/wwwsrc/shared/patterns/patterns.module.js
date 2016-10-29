import angular from 'angular';

import Pattern from './Pattern.factory.js';
import PatternAdvice from './PatternAdvice.factory.js';
import AlzimersPattern from './AlzimersPattern.factory.js';

let patterns = angular.module('mm.patterns', [])
    .factory('Pattern', Pattern)
    .factory('PatternAdvice', PatternAdvice)
    .factory('AlzimersPattern', AlzimersPattern);

export default patterns.name;