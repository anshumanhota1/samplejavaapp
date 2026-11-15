pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'

                git url: 'https://github.com/anshumanhota1/samplejavaapp.git'
            }
        }

        stage('Compile') {
            steps {
                echo 'Compiling source code...'

                sh 'mvn compile'
            }
        }

        stage('CodeReview-PMD') {
            steps {
                echo 'Starting PMD Code Review...'

                sh 'mvn -P metrics pmd:pmd'

                sh 'test -f target/pmd.xml'
            }

            post {
                success {
                    echo 'Publishing PMD analysis results...'

                    recordIssues(
                        enabledForFailure: true,
                        tools: [pmdParser(pattern: '**/target/pmd.xml')]
                    )
                }
            }
        }

        stage('Unit-Test') {
            steps {
                echo 'Executing unit tests...'

                sh 'mvn test'
            }

            post {
                always {
                    junit(
                        testResults: 'target/surefire-reports/*.xml',
                        allowEmptyResults: true
                    )
                }
            }
        }

        stage('Code-Coverage') {
            steps {
                echo 'Generating JaCoCo code coverage report...'

                sh 'mvn jacoco:report'

                sh 'test -f target/site/jacoco/jacoco.xml'
            }

            post {
                success {
                    echo 'Publishing JaCoCo coverage results...'

                    recordCoverage(
                        tools: [[
                            parser: 'JACOCO',
                            pattern: 'target/site/jacoco/jacoco.xml'
                        ]]
                    )
                }
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging application...'

                sh 'mvn package'
            }
        }
    }

    post {

        success {
            emailext(
                to: 'anurudrapal100@gmail.com',
                subject: "SUCCESS: ${JOB_NAME} - Build #${BUILD_NUMBER}",
                body: """
Hello Anjali,

Your Jenkins Maven pipeline completed successfully.

Job: ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Status: SUCCESS
Repository: https://github.com/anshumanhota1/samplejavaapp.git
Build URL: ${BUILD_URL}

Completed stages:
1. Checkout
2. Compile
3. PMD Code Review
4. Unit Testing
5. JaCoCo Code Coverage
6. Package

Regards,
Jenkins CI/CD
"""
            )
        }

        failure {
            emailext(
                to: 'anurudrapal100@gmail.com',
                subject: "FAILURE: ${JOB_NAME} - Build #${BUILD_NUMBER}",
                body: """
Hello Anjali,

Your Jenkins Maven pipeline has failed.

Job: ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Status: FAILURE
Build URL: ${BUILD_URL}

Please check Jenkins Console Output for details.

Regards,
Jenkins CI/CD
"""
            )
        }
    }
}
