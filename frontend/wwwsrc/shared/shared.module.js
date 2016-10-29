import angular from 'angular';

import models from './models/models.module.js';
import patterns from './patterns/patterns.module.js';

let shared = angular.module('mm.shared', [models, patterns]);

export default shared.name;