import './mm-toolbar.scss';
import template from './mm-toolbar.html';

export default {
     template,
     controller: function ($mdSidenav) {
         "ngInject";

        this.openSidenav = () => {
            $mdSidenav('left').toggle();
        };

        this.openUsernav = () => {
            $mdSidenav('right').toggle();
        };
     },
     controllerAs: 'Toolbar'
}