###############################################################################
# The FUSE driver needs elevated privileges, run Docker with --privileged=true
###############################################################################

FROM guysoft/kube-s3
ENV IAM_ROLE=none
ENV S3_REGION ''

COPY docker-entrypoint.sh /
CMD /docker-entrypoint.sh
