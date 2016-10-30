import angular from 'angular';

import mockSupermarkets from './mockSupermarkets.factory.js';

let mocks = angular.module('mm.mocks', [])
    .factory('mockSupermarkets', mockSupermarkets);

export default mocks.name;