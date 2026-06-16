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

            output: {
                serviceName: z =>
                    z.string({
                        description: 'Nome do serviço criado',
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

                catalogInfoPath: z =>
                    z.string({
                        description: 'Catalog info path',
                    }),
            },
        },

        async handler(ctx) {

            ctx.logger.info(`Workspace: ${ctx.workspacePath}`);

            const generateServiceResponse = await axios.post(
                'http://localhost:8000/generate-service',
                {
                    serviceName: ctx.input.serviceName,
                    packageName: ctx.input.packageName,
                    containerPort: ctx.input.containerPort,
                    nodePort: ctx.input.nodePort,
                    targetPath: ctx.workspacePath,
                },
            );

            ctx.logger.info(
                `Service generated: ${generateServiceResponse.data.service}`,
            );

            ctx.output(
                'serviceName',
                generateServiceResponse.data.service,
            );

            ctx.output(
                'packageName',
                ctx.input.packageName,
            );

            ctx.output(
                'containerPort',
                ctx.input.containerPort,
            );

            ctx.output(
                'nodePort',
                ctx.input.nodePort,
            );
        },
    });
};