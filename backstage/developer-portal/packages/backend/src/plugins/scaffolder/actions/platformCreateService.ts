import { createTemplateAction } from '@backstage/plugin-scaffolder-node';
import axios from 'axios';

export const platformCreateService = () => {
    return createTemplateAction({
        id: 'platform:create-service',

        schema: {
            input: {
                serviceName: z =>
                    z.string({
                        description: 'Nome do microserviço',
                    }),

                packageName: z =>
                    z.string({
                        description: 'Package Java',
                    }),

                containerPort: z =>
                    z.number({
                        description: 'Porta do container',
                    }),

                nodePort: z =>
                    z.number({
                        description: 'NodePort Kubernetes',
                    }),
            },
        },

        async handler(ctx) {
            const response = await axios.post(
                'http://localhost:8000/generate-service',
                {
                    serviceName: ctx.input.serviceName,
                    packageName: ctx.input.packageName,
                    containerPort: ctx.input.containerPort,
                    nodePort: ctx.input.nodePort,
                },
            );

            ctx.logger.info(
                `Service generated: ${response.data.service}`,
            );
        },
    });
};