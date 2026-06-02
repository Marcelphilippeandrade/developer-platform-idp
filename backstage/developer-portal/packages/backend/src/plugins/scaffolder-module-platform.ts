import { createBackendModule } from '@backstage/backend-plugin-api';

import { scaffolderActionsExtensionPoint } from '@backstage/plugin-scaffolder-node';

import { platformCreateService } from './scaffolder/actions/platformCreateService';

const scaffolderModulePlatform = createBackendModule({
    pluginId: 'scaffolder',
    moduleId: 'platform',

    register(reg) {
        reg.registerInit({
            deps: {
                scaffolder: scaffolderActionsExtensionPoint,
            },

            async init({ scaffolder }) {
                scaffolder.addActions(
                    platformCreateService(),
                );
            },
        });
    },
});

export default scaffolderModulePlatform;