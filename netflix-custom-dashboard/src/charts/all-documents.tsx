import { useEffect, useState } from "react";
import { getDocuments } from "../http-service";


export const AllDocuments: React.FC<{ className?: string }> = ({ className }) => {

    const [documents, setDocuments] = useState<any[]>([]);

    useEffect(() => {
        getDocuments().then((documents) => {
            if (documents && documents.records.length > 0) {
                setDocuments(documents.records);
            } else {
                console.error('No documents found');
                setDocuments([]);
            }
        });
    }, []);

    return (
        <div>

            {documents.length > 0 ? (
                <div className="row g-4">
                    {documents.map((document, index) => (
                        <div key={index} className="col-md-6 col-lg-4">
                            <div className="card h-100 shadow-sm">
                                <div className="card-body">
                                    <h5 className="card-title text-primary mb-3">{document.name}</h5>
                                    <div className="card-details">
                                        <div className="detail-item mb-2">
                                            <span className="detail-label">Owner:</span>
                                            <span className="detail-value">{document.owner?.name || 'N/A'}</span>
                                        </div>
                                        <div className="detail-item mb-2">
                                            <span className="detail-label">Scope:</span>
                                            <span className={`badge ${document.scope === 'restricted' ? 'bg-warning' : 'bg-success'}`}>
                                                {document.scope}
                                            </span>
                                        </div>
                                        <div className="detail-item mb-2">
                                            <span className="detail-label">Connection ID:</span>
                                            <span className="detail-value text-muted small">{document.connectionId}</span>
                                        </div>
                                        <div className="detail-item mb-2">
                                            <span className="detail-label">Deleted:</span>
                                            <span className={`badge ${document.deleted ? 'bg-danger' : 'bg-success'}`}>
                                                {document.deleted ? 'Yes' : 'No'}
                                            </span>
                                        </div>
                                        <div className="detail-item mb-2">
                                            <span className="detail-label">Folder:</span>
                                            <span className="detail-value">{document.folder?.name || 'N/A'}</span>
                                        </div>
                                        <div className="detail-item mb-2">
                                            <span className="detail-label">Has Dashboard:</span>
                                            <span className={`badge ${document.hasDashboard ? 'bg-info' : 'bg-secondary'}`}>
                                                {document.hasDashboard ? 'Yes' : 'No'}
                                            </span>
                                        </div>
                                        <div className="detail-item mb-2">
                                            <span className="detail-label">Identifier:</span>
                                            <span className="detail-value font-monospace small">{document.identifier}</span>
                                        </div>
                                        <div className="detail-item">
                                            <span className="detail-label">Updated At:</span>
                                            <span className="detail-value text-muted small">
                                                {new Date(document.updatedAt).toLocaleString()}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            ) : (
                <div className="alert alert-info" role="alert">
                    Loading documents...
                </div>
            )}        </div>
    )
}