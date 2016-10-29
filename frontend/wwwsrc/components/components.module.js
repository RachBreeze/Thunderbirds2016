import angular from 'angular';

import mmApp from './mm-app/mm-app.component.js';
import mmToolbar from './mm-toolbar/mm-toolbar.component.js';
import mmSidebar from './mm-sidebar/mm-sidebar.component.js';
import mmMap from './mm-map/mm-map.component.js';

let componentsModule = angular.module('mm.components', [])
    .component('mmApp', mmApp)
    .component('mmToolbar', mmToolbar)
    .component('mmSidebar', mmSidebar)
    .component('mmMap', mmMap);

export default componentsModule.name;