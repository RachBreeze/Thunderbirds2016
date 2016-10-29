import angular from 'angular';

import models from './models/models.module.js';

let shared = angular.module('mm.shared', [models]);

export default shared.name;