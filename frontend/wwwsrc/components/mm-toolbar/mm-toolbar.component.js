import './mm-toolbar.scss';
import template from './mm-toolbar.html';

export default {
     template,
     controller: function ($mdSidenav) {
         "ngInject";

        this.openSidenav = () => {
            $mdSidenav('left').toggle();
        }


     },
     controllerAs: 'Toolbar'
}