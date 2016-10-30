import contacts from './contacts.json';
import './mm-sidebar.scss';
import template from './mm-sidebar.html';

export default {
    template,
    controller: function () {
        this.getContacts = () => {
            return contacts;
        }
    },
    controllerAs: 'Sidebar'
}