import angular from 'angular';

import models from './models/models.module.js';
import patterns from './patterns/patterns.module.js';
import mocks from './mocks/mocks.module.js';
import loading from './loading/loading.module.js';

let shared = angular.module('mm.shared', [models, patterns, mocks, loading]);

export default shared.name;