import { module } from 'qunit';
import startApp from '../helpers/start-app';
import destroyApp from '../helpers/destroy-app';
import RSVP from 'rsvp';

export default function(name, options = {}) {
  module(name, {
    beforeEach() {
      this.application = startApp();

      if (options.beforeEach) {
        return options.beforeEach(...arguments);
      }
    },

    afterEach() {
      let afterEach = options.afterEach && options.afterEach(...arguments);
      return RSVP.Promise.resolve(afterEach).then(() => destroyApp(this.application));
    }
  });
}
